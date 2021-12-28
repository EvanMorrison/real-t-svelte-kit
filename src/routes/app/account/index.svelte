<script lang="ts" context="module">
	import type { Load } from '@sveltejs/kit';

	export const load: Load = async ({ fetch }) => {
		const res = await fetch('/api/account.json');

		const profile = await res.json();

		return {
			props: {
				profile
			}
		};
	};
</script>

<script lang="ts">
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import Header from '$lib/pageComponents/navigationHeader.svelte';
	import { enhance } from '$lib/actions/form';

	export let profile: Partial<User> = {};

	let success: string;

	const saveResult = async (res: Response) => {
		if (res.ok) {
			success = 'Profile updated.';
			setTimeout(() => {
				success = null;
			}, 4000);
		}
	};
</script>

<Header />
<div class="flex flex-col items-center">
	<h1 class="text-2xl py-8">MANAGE ACCOUNT</h1>
	<div class="relative w-full min-h-[1.5rem]">
		{#if success}
			<div class="absolute left-1/2 -translate-x-1/2 text-green-600">{success}</div>
		{/if}
	</div>
	<div class="w-11/12 max-w-2xl flex gap-36 sm:flex-col md:flex-row">
		<h2 class="text-lg">Profile:</h2>
		<section class="flex-1">
			<form
				use:enhance={{
					result: saveResult
				}}
				action="/api/account.json?_method=patch"
				method="POST"
			>
				<input type="hidden" id="userId" name="userId" bind:value={profile.userId} />
				<InputField
					id="firstName"
					name="firstName"
					label="First name"
					placeholder=" "
					bind:value={profile.firstName}
				/>
				<InputField
					id="lastName"
					name="lastName"
					label="Last name"
					placeholder=" "
					bind:value={profile.lastName}
				/>
				<div>
					<Button>Save</Button>
				</div>
			</form>
		</section>
	</div>
</div>
