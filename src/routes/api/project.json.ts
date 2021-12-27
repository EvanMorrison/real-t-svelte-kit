import type { RequestHandler } from '@sveltejs/kit';
import { prisma } from '$lib/prisma';
import { bodyParser } from '$lib/bodyParser';
import { checkAuth } from '$lib/checkAuth';

export const get: RequestHandler = () => {};

export const post: RequestHandler = async (request) => {
	try {
		const auth = checkAuth(request);
		if (!auth.isAuthorized) return auth.unauthorizedResponse;

		const data = bodyParser<Record<string, string>>(request.body);

		const project = await prisma.project.create({
			data: {
				projectType: data.projectType,
				createdByUserId: (
					await prisma.user.findUnique({ where: { email: request.locals.user.email } })
				).userId
			}
		});

		if (request.headers.accept !== 'application/json') {
			return {
				status: 302,
				headers: {
					location: `/app/project-edit/${project.projectId}`
				}
			};
		}

		return {
			status: 200,
			body: {
				projectId: project.projectId,
				projectType: project.projectType
			}
		};
	} catch (error) {
		console.error(error);
		return {
			status: 500,
			body: {
				message: 'An error occurred trying to create a project.'
			}
		};
	}
};
