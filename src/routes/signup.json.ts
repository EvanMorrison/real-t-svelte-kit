import type { Request, RequestHandler } from '@sveltejs/kit';
import bcrypt from 'bcryptjs';
import { serialize } from 'cookie';
import { bodyParser } from '$lib/bodyParser';
import PrismaClient from '$lib/prisma';

const prisma = new PrismaClient();
const saltRounds = 10;

export const post: RequestHandler = async (request: Request) => {
	const data = bodyParser<UserSignup>(request.body);

	const existingUser = await prisma.user.findFirst({
		where: {
			email: data.email
		}
	});

	if (existingUser?.userId) {
		return {
			status: 400,
			body: {
				message: 'Could not create an account',
				fields: {
					email: 'Email is already registered to an account'
				}
			}
		};
	}

	if (data.password.length < 8) {
		return {
			status: 400,
			body: {
				message: 'Could not create an account',
				fields: {
					password: 'Password must be at least 8 characters long.'
				}
			}
		};
	}

	if (data.password !== data.passConfirm) {
		return {
			status: 400,
			body: {
				message: 'Could not create an account',
				fields: {
					passConfirm: 'Passwords do not match'
				}
			}
		};
	}

	const hashedPass = await bcrypt.hash(data.password, saltRounds);

	const newUser = await prisma.user.create({
		data: {
			email: data.email,
			password: hashedPass
		}
	});

	const session = await prisma.session.create({
		data: {
			userId: newUser.userId
		}
	});

	const headers = {
		'Set-Cookie': serialize('sessionId', session.sessionId, {
			path: '/',
			httpOnly: true,
			sameSite: 'strict',
			secure: process.env.NODE_ENV === 'production',
			maxAge: 60 * 60 * 24 * 7 // one week
		})
	};

	if (request.headers.accept !== 'application/json') {
		return {
			status: 302,
			headers: {
				...headers,
				location: '/app'
			}
		};
	}

	return {
		status: 200,
		headers
	};
};
