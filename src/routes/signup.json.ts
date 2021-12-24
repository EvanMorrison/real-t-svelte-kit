import type { Request, RequestHandler } from '@sveltejs/kit';
import bcrypt from 'bcrypt';
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

	await prisma.user.create({
		data: {
			email: data.email,
			password: hashedPass
		}
	});

	if (request.headers.accept !== 'application/json') {
		return {
			status: 302,
			headers: {
				location: '/app'
			}
		};
	}

	return {
		status: 200
	};
};
