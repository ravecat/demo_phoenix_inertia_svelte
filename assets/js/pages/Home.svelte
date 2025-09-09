<script>
  let { message } = $props();
</script>

<svelte:head>
  <title>Phoenix + Inertia + Svelte 5</title>
</svelte:head>

<div class="min-h-screen flex items-center justify-center bg-base-200">
  <div class="text-center max-w-lg w-full px-4">
    <h1 class="text-5xl font-bold mb-6">Inertia.js Demo</h1>
    <p class="text-lg mb-8">{message}</p>
    <div class="flex flex-col gap-4">
      <button
        class="btn btn-primary w-48 mx-auto"
        onclick={() => alert("Svelte 5 reactivity works!")}
      >
        Test Reactivity
      </button>
      <a href="/lv" class="btn btn-secondary w-48 mx-auto">
        LiveView Page
      </a>
      <a
        href="https://inertiajs.com/"
        class="btn btn-outline w-48 mx-auto"
        target="_blank"
      >
        Learn More
      </a>
    </div>
  </div>
</div>
