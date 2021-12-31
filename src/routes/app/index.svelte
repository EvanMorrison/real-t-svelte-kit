<script lang="ts">
	import { getContext } from 'svelte';

	const user: CurrentUser = getContext('currentUser');
</script>

<div class="bg-indigo-500 p-2 h-52 text-white relative flex flex-col justify-end  items-center">
	<div class="text-center">
		<p class="text-3xl">Welcome!</p>
		<p>Let's Get Started.</p>
	</div>
</div>
<div class="pt-8">
	<div>
		<div class="flex justify-around py-8">
			<div class="grid-item">
				<a class="main-nav-links" href="app/projects">
					<h1>All Projects</h1>
					<span class="material-icons-round home-icon">view_list</span>
				</a>
			</div>
			<div class="grid-item">
				<a class="main-nav-links" href="app/project-create">
					<h1>New Project</h1>
					<span class="material-icons-round home-icon">create_new_folder</span>
				</a>
			</div>
			<div class="grid-item">
				<a class="main-nav-links" href="app/contacts">
					<h1>Contacts</h1>
					<span class="material-icons-round home-icon">people</span>
				</a>
			</div>
			<div class="grid-item">
				<a class="main-nav-links" href="app/property">
					<h1>Property</h1>
					<span class="material-icons-round home-icon">terrain</span>
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
