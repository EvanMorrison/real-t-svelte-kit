import type { ReadOnlyFormData } from '@sveltejs/kit/types/helper';

export function bodyParser<T>(body: string | Uint8Array | ReadOnlyFormData): T {
	if (typeof body === 'string') return null;

	return [...body.entries()].reduce((result, [key, val]) => {
		let value: unknown = val;
		if (val === 'true') value = true;
		if (val === 'false') value = false;
		if (key in result) {
			result[key] = Array.isArray(result[key]) ? [...result[key], value] : [result[key], value];
		} else {
			result[key] = value;
		}
		return result;
	}, {}) as T;
}
