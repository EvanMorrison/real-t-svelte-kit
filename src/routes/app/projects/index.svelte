<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch }) => {
		const response = await fetch('/api/projects.json', {
			headers: {
				accept: 'application/json'
			}
		});

		const data = await response.json();

		return {
			props: {
				projects: data.projects
			}
		};
	};
</script>

<script lang="ts">
	import Header from '$lib/pageComponents/navigationHeader.svelte';

	export let projects;
</script>

<Header />
<div class="flex flex-col items-center">
	<h1 class="text-2xl py-8">PROJECTS</h1>
	<div class="w-11/12 max-w-xl">
		<table class="w-11/12">
			<thead>
				<th> id </th>
				<th> project type </th>
				<th> property address </th>
			</thead>
			<tbody>
				{#each projects as project (project.projectId)}
					<tr>
						<td
							><span
								><a href={`/app/project-edit/${project.projectId}`}>{project.projectId}</a></span
							></td
						>
						<td><span>{project.projectType || 'N/A'}</span></td>
						<td
							><span>{(project.parcels[0] && project.parcels[0].property.street1) || 'N/A'}</span
							></td
						>
					</tr>
				{/each}
			</tbody>
		</table>
	</div>
</div>
