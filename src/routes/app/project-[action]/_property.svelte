<script lang="ts">
	import Button from '$lib/components/button.svelte';
	import InputField from '$lib/components/inputField.svelte';

	let property: Property;

	const handleSave = (event: Event) => {
		event.preventDefault();
	};
</script>

<div class="w-11/12 max-w-4xl p-8 mx-auto shadow-lg">
	<div class="p-4 border-2 border-indigo-50 rounded-md">
		<h2 class="text-xl">PROPERTY:</h2>
		<form on:submit|preventDefault={handleSave}>
			<div class="p-4">
				<h3 class="text-lg">Address:</h3>
				<div class="px-4">
					<InputField id="street1" label="Street 1" placeholder=" " bind:value={property.street1} />
					<InputField id="street2" label="Street 2" placeholder=" " bind:value={property.street2} />
					<div class="flex gap-4">
						<div class="flex-1">
							<InputField id="city" label="City" placeholder=" " bind:value={property.city} />
						</div>
						<div class="max-w-[80px] flex-none">
							<InputField id="state" label="State" placeholder="UT" bind:value={property.state} />
						</div>
						<div>
							<InputField
								id="zipCode"
								label="Zip code"
								placeholder=" "
								bind:value={property.zipCode}
							/>
						</div>
					</div>
				</div>
			</div>
			<div class="p-4">
				<h3 class="text-lg">Description:</h3>
				<div class="px-4">
					<div class="flex gap-4">
						<div class="flex-1">
							<InputField id="county" label="County" placeholder=" " bind:value={property.county} />
						</div>
						<div class="flex-1">
							<InputField
								id="parcelId"
								label="Parcel Id"
								placeholder=" "
								bind:value={property.parcelId}
							/>
						</div>
					</div>
					<InputField
						id="shortDescription"
						label="Short Description"
						placeholder=" "
						bind:value={property.shortDescription}
					/>
					<InputField
						textarea
						id="legalDescription"
						label="Legal Description"
						placeholder=" "
						rows="5"
						bind:value={property.legalDescription}
					/>
				</div>
			</div>
			<Button on:click={handleSave}>Save</Button>
		</form>
	</div>
</div>
