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
	import { fade } from 'svelte/transition';
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import Header from '$lib/pageComponents/navigationHeader.svelte';
	import AddressBlock from '$lib/components/addressBlock.svelte';
	import { enhance } from '$lib/actions/form';

	export let action: string;
	export let project: Partial<Project>;

	let addingParty = false;
	let property: Property = {};
	let savedPartySuccess = false;

	$: console.log('project', project);

	const onSaveParty = async (res: Response, form: HTMLFormElement) => {
		if (res.ok) {
			savedPartySuccess = true;
			form.reset();
			addingParty = false;
			project = await res.json();
			setTimeout(() => {
				savedPartySuccess = false;
			}, 4000);
		}
	};

	const handleSave = async (e: Event) => {
		e.preventDefault();

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
		<div class="flex flex-col gap-8 min-w-[300px] sticky top-0 left-0 px-6 pt-16">
			<div><span class="font-bold mr-2">Project Type:</span> {project.projectType}</div>
			<div>Parties</div>
		</div>
		<div class="flex-1 relative p-4 px-8">
			<h1 class="text-left text-2xl capitalize my-4">
				{action} a project
			</h1>
			<h2 class="text-lg py-4">PARTIES</h2>
			<div class="min-h-[1.5rem] text-green-600">
				{#if savedPartySuccess}
					<div>Party was successfully saved!</div>
				{/if}
			</div>
			<div>
				{#each project.parties as party (party.partyId)}
					<div>{party.contact.nickname}</div>
					<div>{party.contact.org}</div>
				{:else}
					{#if !addingParty}
						<div>There's no one here yet.</div>
					{/if}
				{/each}
				{#if addingParty}
					<div class="max-w-lg p-2 border-2 rounded-md" in:fade>
						<form
							use:enhance={{
								result: onSaveParty
							}}
							action={`/api/project-${project.projectId}.json?`}
							method="POST"
						>
							<input type="hidden" name="partyOrParcel" value="party" />
							<div class="max-w-xs">
								<InputField id="role" name="role" label="Role (Buyer/Seller)" />
							</div>
							<div in:fade>
								<div>Person Detail</div>
								<div class="flex gap-4">
									<div class="max-w-[60px] flex-none">
										<InputField id="prefix" label="Prefix" />
									</div>
									<div class="flex-1">
										<InputField id="fullName" label="Full name" />
									</div>
									<div class="max-w-[60px] flex-none">
										<InputField id="suffix" label="Suffix" />
									</div>
								</div>
								<div class="max-w-[50%]">
									<InputField id="nickname" label="Nickname or preferred name" />
								</div>
								<div class="flex gap-4">
									<InputField id="email" label="Email" />
									<InputField id="phone" label="Phone" />
								</div>
								<InputField id="org" label="Company" />
								<AddressBlock />
							</div>
							<div class="flex gap-4">
								<Button
									variant="text"
									on:click={() => {
										addingParty = false;
									}}
									>Cancel
								</Button>
								<Button>Save</Button>
							</div>
						</form>
					</div>
				{/if}
				{#if !addingParty}
					<Button
						variant="text"
						on:click={() => {
							addingParty = true;
						}}>Add Party</Button
					>
				{/if}
			</div>
			<h2 class="text-lg py-4">PROPERTY</h2>
			<div>
				{#each project.parcels as parcel (parcel)}
					<div>{parcel}</div>
				{:else}
					<div>There's no property yet.</div>
				{/each}
				<Button variant="text">Add Property</Button>
			</div>
		</div>
	</div>
</div>
