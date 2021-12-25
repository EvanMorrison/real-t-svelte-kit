import type { RequestHandler } from '@sveltejs/kit';
import { parse, serialize } from 'cookie';
import PrismaClient from '$lib/prisma';

const prisma = new PrismaClient();

export const get: RequestHandler = async (request) => {
	const cookies = parse(request.headers.cookie || '');

	if (cookies.sessionId) {
		try {
			await prisma.session.delete({
				where: {
					sessionId: cookies.sessionId
				}
			});
		} catch (error) {
			console.error(error);
		}
	}

	return {
		status: 302,
		headers: {
			'Set-Cookie': serialize('sessionId', '', {
				path: '/',
				expires: new Date(0)
			}),
			location: '/'
		}
	};
};
