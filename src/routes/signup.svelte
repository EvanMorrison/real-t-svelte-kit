<script>
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';
</script>

<div class="flex place-content-center items-center min-h-full">
	<form
		action=""
		method=""
		autocomplete="off"
		class="flex-1 max-w-md flex flex-col items-center border-2 rounded-md p-10"
	>
		<InputField
			label="Email"
			id="email"
			name="email"
			type="email"
			required
			placeholder="email@example.com"
		/>
		<InputField
			label="Password"
			id="password"
			name="password"
			type="password"
			required
			placeholder=" "
		/>
		<InputField
			label="Confirm Password"
			id="pass-confirm"
			name="pass-confirm"
			type="password"
			required
			placeholder=" "
		/>
		<div class="pt-8">
			<Button>Signup</Button>
		</div>
	</form>
</div>
