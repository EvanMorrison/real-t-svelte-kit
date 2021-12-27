import type { Request } from '@sveltejs/kit';

export const checkAuth = (request: Request) => {
	const user: CurrentUser = request.locals.user;
	return {
		isAuthorized: ['ADMIN', 'USER'].includes(user?.role || ''),
		unauthorizedResponse: {
			status: 403,
			body: {
				message: 'Not authorized.'
			}
		}
	};
};
