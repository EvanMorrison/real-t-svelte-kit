import type { RequestHandler } from '@sveltejs/kit';
import { prisma } from '$lib/prisma';
import { bodyParser } from '$lib/bodyParser';
import { checkAuth } from '$lib/checkAuth';

export const get: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	let id: string;
	if (request.query.has('id')) {
		id = request.query.get('id');
	}

	if (!id) {
		const properties = await prisma.property.findMany();

		return {
			status: 200,
			body: properties
		};
	} else if (id !== 'new') {
		const parcel = await prisma.property.findUnique({
			where: {
				propertyId: +id
			}
		});

		return {
			status: 200,
			body: parcel
		};
	} else {
		return {
			status: 200,
			body: {}
		};
	}
};

export const post: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	const data: Property = bodyParser(request.body);

	let id = data.propertyId;
	delete data.propertyId;

	let parcel = {};

	if (!id) {
		parcel = await prisma.property.create({
			data
		});
	} else {
		parcel = await prisma.property.update({
			where: {
				propertyId: +id
			},
			data
		});
	}

	return {
		status: 200,
		body: parcel
	};
};

export const del: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	const id = request.query.get('id');

	await prisma.property.delete({
		where: {
			propertyId: +id
		}
	});

	return {
		status: 200
	};
};
