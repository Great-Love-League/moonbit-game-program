moon build --target wasm
npx wasm4 run target/wasm/release/build/GAME.wasm
moon build --target wasm -g
npx wasm4 run target/wasm/debug/build/GAME.wasm
@REM moon build --source-dir  ./ --target wasm-gc
@REM npx wasm4 run target/wasm-gc/release/build/GAME.wasm
