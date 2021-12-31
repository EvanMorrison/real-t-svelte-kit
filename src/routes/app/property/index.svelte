<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch }) => {
		const resp = await fetch('/api/property.json');

		const properties = await resp.json();

		return {
			props: {
				properties
			}
		};
	};
</script>

<script lang="ts">
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';
	import { goto } from '$app/navigation';

	export let properties: Property[] = [];

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	const clickAddProperty = () => {
		goto('/app/property/parcel-new');
	};

	const clickDeleteProperty = async (id: number) => {
		const resp = await fetch(`/api/property.json?id=${id}`, {
			method: 'DELETE'
		});

		if (resp.ok) {
			properties = properties.filter((property) => property.propertyId !== id);
		}
	};
</script>

{#key mounted}
	<div class="flex justify-center">
		<div class="flex-1 p-4 max-w-4xl" in:fade>
			<h1 class="text-xl text-center py-4">PROPERTY</h1>
			<div class="py-4">
				<button class="p-2" on:click={clickAddProperty}>
					<span class="material-icons-round align-middle">terrain</span> Add Property
				</button>
			</div>
			<div class="w-full flex justify-center">
				<table class="flex-1">
					<thead>
						<tr class="bg-indigo-100">
							<th> Parcel Id </th>
							<th> County </th>
							<th> State </th>
							<th> Short Description </th>
							<th class="max-w-[50px]" />
						</tr>
					</thead>
					<tbody>
						{#each properties as property (property.propertyId)}
							<tr class="even:bg-indigo-100">
								<td
									><a href={`/app/property/parcel-${property.propertyId}`}>
										{property.parcelId}
									</a></td
								>
								<td>{property.county}</td>
								<td>{property.state}</td>
								<td>{property.shortDescription}</td>
								<td class="max-w-[50px]"
									><button on:click={() => clickDeleteProperty(property.propertyId)}
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
