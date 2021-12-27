import type { RequestHandler } from '@sveltejs/kit';
import { checkAuth } from '$lib/checkAuth';
import { prisma } from '$lib/prisma';
import { bodyParser } from '$lib/bodyParser';

export const get: RequestHandler = async (request) => {
	const auth = checkAuth(request);

	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	try {
		const profile = await prisma.user.findUnique({
			where: {
				userId: request.locals.user.userId
			},
			include: {
				person: {
					include: {
						org: true,
						phones: true
					}
				}
			}
		});

		delete profile.password;

		return {
			status: 200,
			body: profile
		};
	} catch (error) {
		console.error(error);
		return {
			status: 500,
			body: {
				message: 'Internal server error occurred.'
			}
		};
	}
};

export const patch: RequestHandler = async (request) => {
	const auth = checkAuth(request);

	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	const data: Partial<User> = bodyParser(request.body);
	console.log('parsed form data', data);
	try {
		const updatedUser = await prisma.user.update({
			where: {
				userId: +data.userId
			},
			data: {
				firstName: data.firstName,
				lastName: data.lastName,
				person: {
					update: {
						firstName: data.firstName,
						lastName: data.lastName
					}
				}
			}
		});
		return {
			status: 200,
			body: updatedUser
		};
	} catch (error) {
		console.error(error);
		return {
			status: 500
		};
	}
};
