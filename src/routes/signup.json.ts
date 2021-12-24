import type { Request, RequestHandler } from '@sveltejs/kit';
import bcrypt from 'bcrypt';
import { bodyParser } from '$lib/bodyParser';
import PrismaClient from '$lib/prisma';

const prisma = new PrismaClient();
const saltRounds = 10;

export const post: RequestHandler = async ({ body }: Request) => {
	const data = bodyParser<UserSignup>(body);

	const existingUser = await prisma.user.findFirst({
		where: {
			Email: data.email
		}
	});

	if (existingUser?.UserId) {
		return {
			status: 400,
			body: {
				message: 'An account with that email already exists',
				fields: {
					email: 'email is already registered to an account'
				}
			}
		};
	}

	if (data.password !== data.passConfirm) {
		return {
			status: 400,
			body: {
				message: 'Passwords do not match',
				fields: {
					passConfirm: 'passwords do not match'
				}
			}
		};
	}

	// TODO: add min password requirements

	const hashedPass = await bcrypt.hash(data.password, saltRounds);

	const newUser = await prisma.user.create({
		data: {
			Email: data.email,
			Password: hashedPass,
			FirstName: ''
		}
	});

	return {
		status: 303,
		headers: {
			location: '/'
		}
	};
};
