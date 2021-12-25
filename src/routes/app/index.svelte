<script lang="ts" context="module">
	export async function load({ session }) {
		if (!session?.user) {
			return {
				status: 302,
				redirect: '/'
			};
		}

		return {
			props: {
				user: session.user
			}
		};
	}
</script>

<script lang="ts">
	export let user: CurrentUser;
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
	<a class="no-underline visited:text-gray-800" href="/logout.json" rel="external"
		>{user.firstName} <span class="material-icons-round align-middle">logout</span> sign out</a
	>
</div>
<div>
	<div>
		<div class="flex justify-around py-8">
			<div class="grid-item">
				<div class="main-nav-links" ui-sref="caseList">
					<h1>All Cases</h1>
					<span class="material-icons-round home-icon">view_list</span>
				</div>
			</div>
			<div class="grid-item">
				<div class="main-nav-links" ui-sref="caseDashboard">
					<h1>Case Dashboard</h1>
					<span class="material-icons-round home-icon">chrome_reader_mode</span>
				</div>
			</div>
			<div class="grid-item">
				<div class="main-nav-links" ui-sref="caseSetupStart">
					<h1>New Case</h1>
					<span class="material-icons-round home-icon">create_new_folder</span>
				</div>
			</div>
		</div>
	</div>
</div>

<style>
	.grid-item {
		@apply text-3xl text-gray-500 text-center;
	}

	.home-icon {
		@apply text-8xl;
	}
</style>
