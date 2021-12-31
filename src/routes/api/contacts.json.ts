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
		const contacts = await prisma.contact.findMany();

		return {
			status: 200,
			body: contacts
		};
	} else if (id !== 'new') {
		const contact = await prisma.contact.findUnique({
			where: {
				contactId: +id
			}
		});

		return {
			status: 200,
			body: contact
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

	const data: Contact = bodyParser(request.body);

	let id = data.contactId;
	delete data.contactId;

	let contact = {};

	if (!id) {
		delete data.contactId;

		contact = await prisma.contact.create({
			data
		});
	} else {
		contact = await prisma.contact.update({
			where: {
				contactId: +id
			},
			data
		});
	}

	return {
		status: 200,
		body: contact
	};
};

export const del: RequestHandler = async (request) => {
	const auth = checkAuth(request);
	if (!auth.isAuthorized) return auth.unauthorizedResponse;

	const id = request.query.get('id');

	await prisma.contact.delete({
		where: {
			contactId: +id
		}
	});

	return {
		status: 200
	};
};
