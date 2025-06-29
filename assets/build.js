import esbuild from "esbuild";
import sveltePlugin from "esbuild-svelte";

const args = process.argv.slice(2);
const watch = args.includes("--watch");
const deploy = args.includes("--deploy");
const ssr = args.includes("--ssr");

const clientOpts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  minify: deploy,
  sourcemap: watch && "inline",
  logLevel: "info",
  target: "es2020",
  outdir: "../priv/static/assets/js",
  external: ["*.css", "fonts/*", "images/*"],
  nodePaths: ["../deps"],
  conditions: ["svelte"],
  plugins: [
    sveltePlugin({
      compilerOptions: {
        dev: watch,
        hydratable: true,
        generate: "dom",
        css: "external",
      },
    }),
  ],
};

const serverOpts = {
  entryPoints: ["js/ssr.js"],
  bundle: true,
  minify: false,
  sourcemap: watch && "inline",
  logLevel: "info",
  platform: "node",
  format: "cjs",
  outdir: "../priv",
  external: ["*.css", "fonts/*", "images/*"],
  nodePaths: ["../deps"],
  conditions: ["svelte"],
  plugins: [
    sveltePlugin({
      compilerOptions: {
        dev: watch,
        hydratable: true,
        generate: "ssr",
        css: "external",
      },
    }),
  ],
};

const opts = ssr ? serverOpts : clientOpts;

if (watch) {
  esbuild
    .context(opts)
    .then((ctx) => {
      ctx.watch();
    })
    .catch((_error) => {
      process.exit(1);
    });
} else {
  esbuild.build(opts);
}
