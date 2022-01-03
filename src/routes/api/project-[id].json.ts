import type { RequestHandler } from '@sveltejs/kit';
import { checkAuth } from '$lib/checkAuth';
import { prisma } from '$lib/prisma';
import { bodyParser } from '$lib/bodyParser';

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
						manages: true,
						contact: true
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

export const post: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	interface PartyData {
		partyOrParcel: string;
		avatar?: string;
		prefix?: string;
		fullName?: string;
		suffix?: string;
		nickname?: string;
		email?: string;
		phone?: string;
		org?: string;
		title?: string;
		street?: string;
		city?: string;
		state?: string;
		zipCode?: string;
		role?: string;
	}

	const data: PartyData = bodyParser(request.body);
	console.log('parsed FormData', data);
	const isParty = data.partyOrParcel === 'party';
	try {
		let updatedProject;
		if (isParty) {
			updatedProject = await prisma.project.update({
				where: {
					projectId: +request.params.id
				},
				data: {
					parties: {
						create: [
							{
								role: data.role,
								contact: {
									create: {
										avatar: data.avatar,
										prefix: data.prefix,
										fullName: data.fullName,
										suffix: data.suffix,
										nickname: data.nickname,
										email: data.email,
										phone: data.phone,
										org: data.org,
										title: data.title,
										street: data.street,
										city: data.city,
										state: data.state,
										zipCode: data.zipCode
									}
								}
							}
						]
					}
				},
				include: {
					parcels: {
						include: {
							property: true
						}
					},
					parties: {
						include: {
							manages: true,
							contact: true
						}
					}
				}
			});
		}

		return {
			status: 200,
			body: updatedProject
		};
	} catch (error) {
		console.error(error);
		return { status: 500 };
	}
};
