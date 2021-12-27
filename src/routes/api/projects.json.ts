import type { RequestHandler } from '@sveltejs/kit';
import { checkAuth } from '$lib/checkAuth';
import { prisma } from '$lib/prisma';

export const get: RequestHandler = async (request) => {
	const auth = checkAuth(request);

	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	const projects = await prisma.project.findMany({
		include: {
			parcels: {
				include: {
					property: true
				}
			},
			parties: true
		}
	});

	return {
		status: 200,
		body: {
			projects
		}
	};
};
