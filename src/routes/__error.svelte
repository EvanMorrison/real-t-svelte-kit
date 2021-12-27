<script lang="ts" context="module">
	import type { ErrorLoad } from '@sveltejs/kit';

	export const load: ErrorLoad = ({ error, status }) => {
		return {
			props: {
				error,
				status
			}
		};
	};
</script>

<script lang="ts">
	import Header from '$lib/pageComponents/authPageHeader.svelte';

	export let error: Error;
	export let status: number;

	const goBack = () => {
		window.history.back();
	};
</script>

<Header />
<div class="p-16">
	<h1 class="text-3xl text-center">
		Error {status}: {status === 404
			? "Uh oh, we couldn't find the page you requested."
			: error.message}
	</h1>

	<div class="mt-16 text-lg text-center flex flex-col gap-8">
		<!-- svelte-ignore a11y-invalid-attribute -->
		<div>
			<a href="" on:click={goBack}
				><span class="material-icons-round align-bottom">arrow_back</span>Go back</a
			>.
		</div>
		<div>
			<a href="/app"><span class="material-icons-round align-bottom">home</span>Return home</a>.
		</div>
	</div>
</div>
