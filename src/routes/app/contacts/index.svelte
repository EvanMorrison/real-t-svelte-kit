<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch }) => {
		const resp = await fetch('/api/contacts.json');

		const contacts = await resp.json();

		return {
			props: {
				contacts
			}
		};
	};
</script>

<script lang="ts">
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';
	import { goto } from '$app/navigation';

	export let contacts: Contact[] = [];

	let mounted = false;

	onMount(() => {
		mounted = true;
	});

	const clickAddContact = () => {
		goto('/app/contacts/contact-new');
	};

	const clickDeleteContact = async (id: number) => {
		const resp = await fetch(`/api/contacts.json?id=${id}`, {
			method: 'DELETE'
		});

		if (resp.ok) {
			contacts = contacts.filter((contact) => contact.contactId !== id);
		}
	};
</script>

{#key mounted}
	<div class="flex justify-center">
		<div class="flex-1 p-4 max-w-4xl" in:fade>
			<h1 class="text-xl text-center py-4">CONTACTS</h1>
			<div class="py-4">
				<button class="p-2" on:click={clickAddContact}>
					<span class="material-icons-round align-middle">person_add</span> Add Contact
				</button>
			</div>
			<div class="w-full flex justify-center">
				<table class="flex-1">
					<thead>
						<tr class="bg-indigo-100">
							<th> Name </th>
							<th> Eamil </th>
							<th> Phone </th>
							<th class="max-w-[50px]" />
						</tr>
					</thead>
					<tbody>
						{#each contacts as contact (contact.contactId)}
							<tr class="even:bg-indigo-100">
								<td
									><a href={`/app/contacts/contact-${contact.contactId}`}>
										{contact.nickname
											? `${contact.nickname} ${contact.lastName}`
											: contact.fullName}
									</a></td
								>
								<td>{contact.email}</td>
								<td>{contact.phone}</td>
								<td class="max-w-[50px]"
									><button on:click={() => clickDeleteContact(contact.contactId)}
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
