<script lang="ts">
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import { enhance } from '$lib/actions/form';

	let user: UserLogin = {
		email: '',
		password: ''
	};
	let error = '';

	const handleLoginError = async (res: Response, form: HTMLFormElement) => {
		const result = await res.json();
		console.log('result', result);
		error = result.message;
	};
</script>

<div class="min-h-full flex flex-col gap-10 pt-16">
	<div class="flex place-content-center items-center">
		<form
			use:enhance={{
				result: handleLoginError
			}}
			action="/login.json"
			method="GET"
			autocomplete="off"
			class="flex-1 max-w-md flex flex-col items-center overflow-hidden border-2 rounded-md px-10 pt-0"
		>
			<div class="-mx-10 self-stretch py-4 bg-indigo-400 min-w-full text-white text-center mb-8">
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
