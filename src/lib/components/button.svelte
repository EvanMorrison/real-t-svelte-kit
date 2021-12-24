<script lang="ts">
	import { tweened } from 'svelte/motion';

	let x = 0;
	let y = 0;
	let radius = 0;

	const ripple = tweened({ scale: 0, opacity: 1 });

	const inkAnimation = async (event: MouseEvent) => {
		const btn = event.currentTarget as HTMLElement;
		x = event.offsetX;
		y = event.offsetY;
		radius = Math.max(btn.clientHeight, btn.clientWidth) / 2;
		await ripple.set({ scale: 4, opacity: 0 }, { duration: 500 });
		ripple.set({ scale: 0, opacity: 1 }, { duration: 0 });
	};
</script>

<button
	on:click
	on:click={inkAnimation}
	{...$$props}
	class="
    relative
    border-2
    border-indigo-500
    rounded-md
    px-4
    py-2
    bg-indigo-500
    text-white
    hover:bg-indigo-600
  "
>
	<span
		class="
    ripple
    absolute
    block
    t-0
    b-0
    w-full
    h-full
    rounded-full
  "
		style="--scale: {$ripple.scale}; --opacity: {$ripple.opacity}; --x: {x}px; --y: {y}px; --radius: {radius}px"
	/>
	<slot />
</button>

<style>
	.ripple {
		opacity: var(--opacity);
		width: calc(var(--radius) * 2);
		height: calc(var(--radius) * 2);
		transform: translate(calc(-50% + var(--x)), calc(-50% + var(--y))) scale(var(--scale));
		background-color: hsl(0deg 0% 100% / 0.4);
	}
</style>
