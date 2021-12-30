<script lang="ts">
	import InputField from './inputField.svelte';

	interface Address {
		street1?: string;
		street2?: string;
		city?: string;
		state?: string;
		zipCode?: string;
	}

	export let isEditing = true;
	export let address: Address = {};
</script>

{#if isEditing}
	<div>
		<InputField id="street1" label="Street 1" bind:value={address.street1} />
		<InputField id="street2" label="Street 2" bind:value={address.street2} />
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
	<div>{address.street1}</div>
	{#if address.street2}
		<div>{address.street2}</div>
	{/if}
	<div class="flex gap-4 max-w-full">
		<div class="flex-1">{address.city}</div>
		<div class="basis-[80px] flex-none">{address.state}</div>
		<div class="max-w-[120px]">{address.zipCode}</div>
	</div>
{/if}
