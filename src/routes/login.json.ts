import type { Request, RequestHandler } from '@sveltejs/kit';
import bcrypt from 'bcryptjs';
import { serialize } from 'cookie';
import { bodyParser } from '$lib/bodyParser';
import { prisma } from '$lib/prisma';

export const post: RequestHandler = async (request: Request) => {
	const data = bodyParser<UserLogin>(request.body);

	const existingUser = await prisma.user.findUnique({
		where: {
			email: data.email
		}
	});

	if (!existingUser) {
		return {
			status: 400,
			body: {
				message: 'The email or password were incorrect.'
			}
		};
	}

	const match = await bcrypt.compare(data.password, existingUser.password);

	if (!match) {
		return {
			status: 400,
			body: {
				message: 'The email or password were incorrect.'
			}
		};
	}

	let session: { sessionId: any; userId?: number };

	session = await prisma.session.findFirst({
		where: {
			userId: existingUser.userId
		}
	});

	if (!session) {
		session = await prisma.session.create({
			data: {
				userId: existingUser.userId
			}
		});
	}

	return {
		status: 200,
		headers: {
			'Set-Cookie': serialize('sessionId', session.sessionId, {
				path: '/',
				httpOnly: true,
				sameSite: 'strict',
				secure: process.env.NODE_ENV === 'production',
				maxAge: 60 * 60 * 24 * 7 // one week
			})
		}
	};
};
