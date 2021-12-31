<script lang="ts">
	import InputField from './inputField.svelte';

	interface Address {
		street?: string;
		city?: string;
		state?: string;
		zipCode?: string;
	}

	export let isEditing = true;
	export let address: Address = {};
</script>

{#if isEditing}
	<div>
		<InputField id="street" label="Street" bind:value={address.street} />
		<div class="flex gap-4 max-w-full">
			<div class="flex-1">
				<InputField id="city" label="City" bind:value={address.city} />
			</div>
			<div class="max-w-[80px] flex-none">
				<InputField id="state" label="State" bind:value={address.state} />
			</div>
			<div class="max-w-[120px]">
				<InputField id="zipCode" label="Zip Code" bind:value={address.zipCode} />
			</div>
		</div>
	</div>
{:else}
	<div>{address.street}</div>
	<div class="flex gap-4 max-w-full">
		<div class="flex-1">{address.city}</div>
		<div class="basis-[80px] flex-none">{address.state}</div>
		<div class="max-w-[120px]">{address.zipCode}</div>
	</div>
{/if}
