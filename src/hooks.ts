import type { GetSession, Handle } from '@sveltejs/kit';
import { parse } from 'cookie';
import PrismaClient from '$lib/prisma';

const prisma = new PrismaClient();

export const handle: Handle = async ({ request, resolve }) => {
	const cookies = parse(request.headers.cookie || '');

	if (cookies.sessionId) {
		const session = await prisma.session.findUnique({
			where: { sessionId: cookies.sessionId },
			include: {
				user: true
			}
		});
		if (session) {
			request.locals.user = {
				userId: session.user.userId,
				email: session.user.email,
				role: session.user.role,
				avatar: session.user.avatar || '',
				firstName: session.user.firstName || '',
				lastName: session.user.lastName || ''
			};
		} else {
			request.locals.user = null;
		}
	}

	if (request.query.has('_method')) {
		request.method = request.query.get('_method').toUpperCase();
	}
	return resolve(request);
};

export const getSession: GetSession = (request) => {
	console.log('request locals', request.locals);
	return request.locals.user
		? {
				user: { ...request.locals.user }
		  }
		: {};
};
