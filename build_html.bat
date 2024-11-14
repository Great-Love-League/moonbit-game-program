@REM moon build --target wasm
@REM npx wasm4 bundle --html game.html target/wasm/release/build/GAME.wasm
moon build --source-dir  ./ --target wasm-gc
npx wasm4 bundle --html target/wasm-gc/release/build/GAME.wasm