import type { RequestHandler } from '@sveltejs/kit';
import { checkAuth } from '$lib/checkAuth';
import { prisma } from '$lib/prisma';

export const get: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	try {
		const project = await prisma.project.findUnique({
			where: {
				projectId: +request.params.id
			},
			include: {
				parcels: {
					include: {
						property: true
					}
				},
				parties: {
					include: {
						org: true,
						person: true
					}
				}
			}
		});

		return {
			status: 200,
			body: project
		};
	} catch (error) {
		console.error(error);
		return {
			status: 500
		};
	}
};
