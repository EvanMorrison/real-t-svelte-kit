<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = ({ page }) => {
		return {
			props: {
				action: page.params.action
			}
		};
	};
</script>

<script lang="ts">
	import Header from '$lib/pageComponents/navigationHeader.svelte';

	export let action: string;

	let property: Property = {};
	let project: Project = {};

	const handleSave = async (e: Event) => {
		e.preventDefault();

		console.log('property body', property);

		const response = await fetch('/api/project.json', {
			method: 'PATCH',
			headers: {
				'content-type': 'text/plain',
				accepts: 'application/json'
			},
			body: JSON.stringify(property)
		});

		console.log('response', await response.json());
	};
</script>

<Header />
<h1 class="text-center text-2xl capitalize my-4">
	{action} a project
</h1>
