<script lang="ts">
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import { enhance } from '$lib/actions/form';

	let newUser: UserSignup = {
		email: '',
		password: '',
		passConfirm: ''
	};
	let error = '';
	let passConfirmError = '';

	const handleSignupError = async (res: Response, form: HTMLFormElement) => {
		const result = await res.json();
		error = result.message;
		passConfirmError = result.fields?.passConfirm;
	};
</script>

<div class="min-h-full flex flex-col gap-10 pt-16">
	<div class="flex place-content-center items-center">
		<form
			use:enhance={{
				result: handleSignupError
			}}
			action="/signup.json"
			method="POST"
			autocomplete="off"
			class="flex-1 max-w-md flex flex-col overflow-hidden items-center border-2 rounded-md px-10 pt-0"
		>
			<div class="-mx-10 self-stretch py-4 bg-indigo-400 min-w-full text-white text-center mb-8">
				SIGN UP
			</div>
			{#if error}
				<div class="text-red-600 text-center">{error}</div>
			{/if}
			<InputField
				bind:value={newUser.email}
				label="Email"
				id="email"
				name="email"
				type="email"
				required
				placeholder="email@example.com"
			/>
			<InputField
				bind:value={newUser.password}
				label="Password"
				id="password"
				name="password"
				type="password"
				required
				placeholder=" "
			/>
			<InputField
				bind:value={newUser.passConfirm}
				label="Confirm Password"
				id="passConfirm"
				name="passConfirm"
				type="password"
				required
				error={passConfirmError}
				placeholder=" "
			/>
			<div>
				<Button>Signup</Button>
			</div>
			<div class="flex justify-center my-6">
				<div class="flex-1 max-w-md text-center text-sm">
					Already have an account? <a href="/login"
						><span class="material-icons-round align-middle ml-2 mr-1">login</span>
						Login</a
					>.
				</div>
			</div>
		</form>
	</div>
</div>
