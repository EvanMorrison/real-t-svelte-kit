<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch, page }) => {
		const resp = await fetch(`/api/project-${page.params.id}.json`);
		const project = await resp.json();
		return {
			props: {
				action: page.params.action,
				project
			}
		};
	};
</script>

<script lang="ts">
	import Header from '$lib/pageComponents/navigationHeader.svelte';

	export let action: string;
	export let project: Partial<Project>;

	let property: Property = {};

	$: console.log('project', project);

	const handleSave = async (e: Event) => {
		e.preventDefault();

		console.log('property body', property);

		const response = await fetch('/api/project.json', {
			method: 'PATCH',
			headers: {
				'content-type': 'text/plain',
				accept: 'application/json'
			},
			body: JSON.stringify(property)
		});

		console.log('response', await response.json());
	};
</script>

<div>
	<Header />
	<div class="flex items-start min-h-[3000px]">
		<div class="min-w-[300px] border-2 sticky top-0 left-0 pt-16">
			<div><span class="font-bold mr-2">Project Type:</span> {project.projectType}</div>
		</div>
		<div class="flex-1 relative border-2">
			<h1 class="text-center text-2xl capitalize my-4">
				{action} a project
			</h1>
		</div>
	</div>
</div>
