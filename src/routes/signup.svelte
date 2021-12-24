<script lang="ts">
	import { goto } from '$app/navigation';
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
	import { enhance } from '$lib/actions/form';
	import Header from '$lib/pageComponents/authPageHeader.svelte';

	let newUser: UserSignup = {
		email: '',
		password: '',
		passConfirm: ''
	};
	let error = '';
	let emailError = '';
	let passConfirmError = '';
	let passwordError = '';

	const handleSignupResponse = async (res: Response, form: HTMLFormElement) => {
		if (res.ok) {
			goto('/app');
			return;
		}

		const result = await res.json();
		error = result.message;
		emailError = result.fields?.email;
		passwordError = result.fields?.password;
		passConfirmError = result.fields?.passConfirm;
	};
</script>

<Header />
<div class="min-h-full flex flex-col gap-10 pt-16 bg-indigo-50">
	<div class="flex place-content-center items-center">
		<form
			use:enhance={{
				result: handleSignupResponse
			}}
			action="/signup.json"
			method="POST"
			autocomplete="off"
			class="
        bg-white
        flex-1
        max-w-md
        flex
        flex-col
        overflow-hidden
        items-center
        rounded-md
        px-10
        pt-0
        shadow-md
      "
		>
			<div class="-mx-10 self-stretch py-4 bg-indigo-500 min-w-full text-white text-center mb-8">
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
				error={emailError}
				placeholder="email@example.com"
			/>
			<InputField
				bind:value={newUser.password}
				label="Password"
				id="password"
				name="password"
				type="password"
				required
				error={passwordError}
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
