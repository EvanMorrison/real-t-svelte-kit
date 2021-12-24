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

			if (response.ok) {
				result(response, form);
			} else {
				console.log('Fetch error', await response.text());
			}
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
