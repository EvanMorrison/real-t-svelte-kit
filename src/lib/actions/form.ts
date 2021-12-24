export const enhance = (form: HTMLFormElement, { result }) => {
	const handleSubmit = async (event: Event) => {
		event.preventDefault();

		try {
			const body = new FormData(form);
			const response = await fetch(form.action, {
				method: form.method,
				headers: {
					accept: 'application/json'
				},
				body
			});

			result(response, form);
		} catch (error) {
			console.error(`Fetch error: ${error}`);
		}
	};

	form.addEventListener('submit', handleSubmit);

	return {
		destroy() {
			form.removeEventListener('submit', handleSubmit);
		}
	};
};
