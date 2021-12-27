<script lang="ts">
	import { fade } from 'svelte/transition';
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import { enhance } from '$lib/actions/form';
	import Header from '$lib/pageComponents/authPageHeader.svelte';
	import type { Page } from '@sveltejs/kit';

	export let page: Page;

	let user: UserLogin = {
		email: '',
		password: ''
	};
	let error = '';

	const handleLoginResponse = async (res: Response) => {
		if (res.ok) {
			window.location.href = '/app';
			return;
		}

		const result = await res.json();
		error = result.message;
	};
</script>

<div class="h-full flex flex-col">
	<Header />
	{#key page}
		<div class="flex-1 flex flex-col gap-10 pt-16 bg-indigo-50" in:fade={{ duration: 200 }}>
			<div class="flex place-content-center items-center">
				<form
					use:enhance={{
						result: handleLoginResponse
					}}
					action="/login.json"
					method="POST"
					autocomplete="off"
					class="
					bg-white
					flex-1
					max-w-md
					flex
					flex-col
					items-center
					overflow-hidden
					rounded-md
					px-10
					pt-0
					shadow-md
				"
				>
					<div
						class="-mx-10 self-stretch py-4 bg-indigo-500 min-w-full text-white text-center mb-8"
					>
						LOGIN
					</div>
					{#if error}
						<div class="text-red-600 text-center">{error}</div>
					{/if}
					<InputField
						bind:value={user.email}
						label="Email"
						id="email"
						name="email"
						type="email"
						required
						placeholder="email@example.com"
					/>
					<InputField
						bind:value={user.password}
						label="Password"
						id="password"
						name="password"
						type="password"
						required
						placeholder=" "
					/>
					<div>
						<Button>Login</Button>
					</div>
					<div class="flex justify-center my-6">
						<div class="flex-1 max-w-md text-center text-sm">
							Don't have an account? <a href="/signup"
								><span class="material-icons-round align-middle ml-2 mr-1">person_add</span>
								Sign up</a
							>.
						</div>
					</div>
				</form>
			</div>
		</div>
	{/key}
</div>
