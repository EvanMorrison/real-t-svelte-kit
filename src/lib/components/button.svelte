<button
  on:click
  {...$$props}
  class="
    border-2
    border-indigo-500
    rounded-sm
    px-4
    py-2
    bg-indigo-400
    text-white
    hover:bg-indigo-500
    active:bg-indigo-600
  "
>
  <slot />
</button>
