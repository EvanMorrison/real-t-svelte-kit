<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch, page }) => {
		const id = page.params.id;

		if (id === 'new') {
			return {
				props: {
					parcel: {}
				}
			};
		} else {
			const resp = await fetch(`/api/property.json?id=${id}`);
			const parcel = await resp.json();

			return {
				props: {
					parcel
				}
			};
		}
	};
</script>

<script lang="ts">
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';
	import { goto } from '$app/navigation';
	import { enhance } from '$lib/actions/form';
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';

	export let parcel: Property = {};

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	const onCancel = (event: Event) => {
		event.preventDefault();
		window.history.back();
	};

	const onSave = async (res: Response, form: HTMLFormElement) => {
		if (res.ok) {
			form.reset();
			goto('/app/property');
		}
	};
</script>

{#key mounted}
	<div in:fade class="bg-indigo-50 pb-20">
		<h1 class="text-xl text-center p-4">Add Property</h1>
		<div class="flex justify-center">
			<div class="flex-1 max-w-[500px] p-8 bg-white shadow-md">
				<form
					action="/api/property.json"
					method="POST"
					use:enhance={{
						result: onSave
					}}
				>
					<input type="hidden" id="propertyId" name="propertyId" bind:value={parcel.propertyId} />
					<InputField id="county" label="County" required bind:value={parcel.county} />
					<InputField id="parcelId" label="Parcel Id" bind:value={parcel.parcelId} />
					<div>
						<InputField id="street" label="Street" bind:value={parcel.street} />
						<div class="flex gap-4 max-w-full">
							<div class="flex-1">
								<InputField id="city" label="City" bind:value={parcel.city} />
							</div>
							<div class="max-w-[80px] flex-none">
								<InputField id="state" label="State" bind:value={parcel.state} />
							</div>
							<div class="max-w-[120px]">
								<InputField id="zipCode" label="Zip Code" bind:value={parcel.zipCode} />
							</div>
						</div>
					</div>
					<InputField
						id="shortDescription"
						label="Short description"
						bind:value={parcel.shortDescription}
					/>
					<InputField
						id="legalDescription"
						label="Legal description"
						textarea
						rows="5"
						bind:value={parcel.legalDescription}
					/>

					<div class="flex justify-end gap-4">
						<Button variant="text" type="button" on:click={onCancel}>Cancel</Button>
						<Button>Save</Button>
					</div>
				</form>
			</div>
		</div>
	</div>
{/key}
