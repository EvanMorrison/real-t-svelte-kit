import type { Request, RequestHandler } from '@sveltejs/kit';
import bcrypt from 'bcrypt';
import { bodyParser } from '$lib/bodyParser';
import PrismaClient from '$lib/prisma';

const prisma = new PrismaClient();

export const get: RequestHandler = async ({ body }: Request) => {
	const data = bodyParser<UserLogin>(body);

	const existingUser = await prisma.user.findFirst({
		where: {
			Email: data.email
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

	const match = await bcrypt.compare(data.password, existingUser.Password);

	if (!match) {
		return {
			status: 400,
			body: {
				message: 'The email or password were incorrect.'
			}
		};
	}

	return {
		status: 303,
		headers: {
			location: '/app'
		}
	};
};
