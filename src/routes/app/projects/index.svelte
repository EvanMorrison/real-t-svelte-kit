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
	import { goto } from '$app/navigation';

	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';

	export let projects: Project[] = [];

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	const clickAddProject = () => {
		goto('/app/project-create');
	};

	const clickDeleteProject = (id: number) => {
		console.log(`deleting project Id ${id}`);
	};
</script>

{#key mounted}
	<div class="flex justify-center">
		<div class="flex-1 p-4 max-w-4xl" in:fade>
			<h1 class="text-xl text-center py-4">PROJECTS</h1>
			<div class="py-4">
				<button class="p-2" on:click={clickAddProject}>
					<span class="material-icons-round align-middle">person_add</span> Add Project
				</button>
			</div>
			<div class="w-full flex justify-center">
				<table class="flex-1">
					<thead>
						<tr class="bg-indigo-100">
							<th> Id </th>
							<th> Project Type </th>
							<th> Property Address </th>
							<th class="max-w-[50px]" />
						</tr>
					</thead>
					<tbody>
						{#each projects as project (project.projectId)}
							<tr class="even:bg-indigo-100">
								<td
									><a href={`/app/project-edit/${project.projectId}`}>
										{project.projectId}
									</a></td
								>
								<td>{project.projectType}</td>
								<td>{(project.parcels[0] && project.parcels[0].property.street) || 'N/A'}</td>
								<td class="max-w-[50px]"
									><button on:click={() => clickDeleteProject(project.projectId)}
										><span class="material-icons-round">clear</span></button
									></td
								>
							</tr>
						{/each}
					</tbody>
				</table>
			</div>
		</div>
	</div>
{/key}

<style>
	th {
		@apply text-left;
	}
</style>
