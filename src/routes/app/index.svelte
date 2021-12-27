<script lang="ts">
	import { getContext } from 'svelte';

	const user: CurrentUser = getContext('currentUser');
</script>

<div
	class="bg-indigo-500 p-2 text-white h-[50vh] relative flex flex-col justify-between  items-center"
>
	<div class="self-start mt-[5rem] ml-[5rem]">
		<h1 class="text-9xl font-extralight -ml-2.5">REAL-T</h1>
		<h3>Real Estate Transaction Manager</h3>
	</div>
	<div class="text-center">
		<p class="text-3xl">Welcome!</p>
		<p>Let's Get Started.</p>
	</div>
</div>
<div class="flex justify-end p-2">
	<a class="text-inherit visited:text-inherit" href="/app/account"
		><span class="material-icons-round align-middle text-xl">manage_accounts</span>
		{(user && user.firstName) || user.email || 'Account'}
	</a>
	&nbsp; | &nbsp;
	<a class="text-inherit visited:text-inherit" href="/logout.json" rel="external"
		><span class="material-icons-round align-middle text-xl">logout</span> log out</a
	>
</div>
<div>
	<div>
		<div class="flex justify-around py-8">
			<div class="grid-item">
				<a class="main-nav-links" href="app/projects">
					<h1>All Projects</h1>
					<span class="material-icons-round home-icon">view_list</span>
				</a>
			</div>
			<!-- <div class="grid-item">
				<a class="main-nav-links" href="app/dashboard">
					<h1>Case Dashboard</h1>
					<span class="material-icons-round home-icon">chrome_reader_mode</span>
				</a>
			</div> -->
			<div class="grid-item">
				<a class="main-nav-links" href="app/project-create">
					<h1>New Project</h1>
					<span class="material-icons-round home-icon">create_new_folder</span>
				</a>
			</div>
		</div>
	</div>
</div>

<style>
	.grid-item a {
		@apply text-3xl text-gray-500 text-center no-underline flex flex-col items-center;
	}

	.home-icon {
		@apply text-8xl;
	}
</style>
