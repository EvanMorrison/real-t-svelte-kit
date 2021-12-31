<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch, page }) => {
		const id = page.params.id;

		if (id === 'new') {
			return {
				props: {
					contact: {}
				}
			};
		} else {
			const resp = await fetch(`/api/contacts.json?id=${id}`);
			const contact = await resp.json();

			return {
				props: {
					contact
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

	export let contact: Contact = {};

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	const setFullName = () => {
		if (!contact.fullName) {
			contact.fullName = `${contact.firstName.trim()} ${contact.lastName.trim()}`;
		}
	};

	const setNickname = () => {
		if (!contact.nickname) {
			contact.nickname = contact.firstName;
		}
	};

	const onCancel = (event: Event) => {
		event.preventDefault();
		window.history.back();
	};

	const onSave = async (res: Response, form: HTMLFormElement) => {
		if (res.ok) {
			form.reset();
			goto('/app/contacts');
		}
	};
</script>

{#key mounted}
	<div in:fade class="bg-indigo-50 pb-20">
		<h1 class="text-xl text-center p-4">Create Contact</h1>
		<div class="flex justify-center">
			<div class="flex-1 max-w-[500px] p-8 bg-white shadow-md">
				<form
					action="/api/contacts.json"
					method="POST"
					use:enhance={{
						result: onSave
					}}
				>
					<input type="hidden" id="contactId" name="contactId" bind:value={contact.contactId} />
					<InputField
						id="firstName"
						label="First Name"
						required
						bind:value={contact.firstName}
						on:blur={setNickname}
					/>
					<InputField
						id="lastName"
						label="Last Name"
						bind:value={contact.lastName}
						on:blur={setFullName}
					/>
					<InputField id="fullName" label="Full Name" bind:value={contact.fullName} />
					<div class="w-[300px]">
						<InputField
							id="nickname"
							label="Preferred first name/nickname"
							bind:value={contact.nickname}
						/>
					</div>
					<div class="flex gap-4">
						<InputField id="email" label="Email" type="email" bind:value={contact.email} />
						<InputField id="phone" label="Phone" bind:value={contact.phone} />
					</div>
					<InputField id="org" label="Company, Organization or Trust" bind:value={contact.org} />
					<InputField id="title" label="Contact's title" bind:value={contact.title} />

					<div>
						<InputField id="street" label="Street" bind:value={contact.street} />
						<div class="flex gap-4 max-w-full">
							<div class="flex-1">
								<InputField id="city" label="City" bind:value={contact.city} />
							</div>
							<div class="max-w-[80px] flex-none">
								<InputField id="state" label="State" bind:value={contact.state} />
							</div>
							<div class="max-w-[120px]">
								<InputField id="zipCode" label="Zip Code" bind:value={contact.zipCode} />
							</div>
						</div>
					</div>

					<div class="flex justify-end gap-4">
						<Button variant="text" type="button" on:click={onCancel}>Cancel</Button>
						<Button>Save</Button>
					</div>
				</form>
			</div>
		</div>
	</div>
{/key}
