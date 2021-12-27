<script lang="ts">
	import { getContext, hasContext } from 'svelte';

	const currentUser: CurrentUser = hasContext('currentUser') ? getContext('currentUser') : null;
</script>

<div
	class="
    bg-indigo-500
    text-white
    p-2
    relative
    flex
    justify-between
    items-center
  "
>
	<div class="self-start my-1 ml-[5rem]">
		<h1 class="text-9xl font-extralight -ml-2.5">REAL-T</h1>
		<h3>Real Estate Transaction Manager</h3>
	</div>
	<div class="text-white self-start text-lg px-4">
		<a class="text-inherit visited:text-inherit" href="/app/account"
			>{(currentUser && currentUser.firstName) || currentUser.email || 'Account'}
			<span class="material-icons-round align-bottom text-xl">manage_accounts</span></a
		>
		|
		<a class="text-inherit visited:text-inherit" href="/logout.json" rel="external"
			>log out <span class="material-icons-round align-bottom text-xl">logout</span></a
		>
	</div>
</div>
