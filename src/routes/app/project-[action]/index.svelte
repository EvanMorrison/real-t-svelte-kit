<script lang="ts">
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';
	import { goto } from '$app/navigation';
	import { enhance } from '$lib/actions/form';
	import Button from '$lib/components/button.svelte';
	import Header from '$lib/pageComponents/navigationHeader.svelte';

	let projectType: string;
	let error: string;
	let key = false;

	onMount(() => {
		key = true;
	});

	const handleCreateProject = async (res: Response) => {
		console.log('got response', res);
		if (res.ok) {
			const result = await res.json();
			goto(`/app/project-edit/${result.projectId}`);
			return;
		}

		const result = await res.json();
		error = result.message;
	};

	const onCancel = (e: Event) => {
		e.preventDefault();
		window.history.back();
	};
</script>

<div class="h-full flex flex-col">
	<Header />
	{#key key}
		<div class="flex-1 flex flex-col gap-10 pt-16 bg-indigo-50" in:fade={{ duration: 200 }}>
			<div class="flex place-content-center items-center">
				<form
					use:enhance={{
						result: handleCreateProject
					}}
					action="/api/project.json"
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
						CREATE A PROJECT
					</div>
					{#if error}
						<div class="text-red-600 text-center">{error}</div>
					{/if}

					<div class="mt-4">
						<label for="projectType">Type of Transaction:</label>
						<select
							class="py-2 px-1 border-2 border-indigo-600 rounded-md outline-offset-2 outline-indigo-200"
							id="projectType"
							name="projectType"
							bind:value={projectType}
						>
							<option value="buySell">Purchase and Sale</option>
							<option value="finance">Financing</option>
							<option value="foreclosure">Foreclosure</option>
							<option value="landDevelopment">Land Development</option>
							<option value="research">Research</option>
						</select>
					</div>
					<div class="my-8">
						<Button variant="text" on:click={onCancel}>Cancel</Button>
						<Button>Create</Button>
					</div>
				</form>
			</div>
		</div>
	{/key}
</div>
