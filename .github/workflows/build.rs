extern crate autocfg;

fn main() {
    let ac = autocfg::new();
    ac.emit_has_type("i128");

    // (optional) We don't need to rerun for anything external.
    autocfg::rerun_path("build.rs");
}
[build-dependencies]
autocfg = "1"
use embed_manifest::{embed_manifest, new_manifest};

fn main() {
    if std::env::var_os("CARGO_CFG_WINDOWS").is_some() {
        embed_manifest(new_manifest("Contoso.Sample"))
            .expect("unable to embed manifest file");
    }
    println!("cargo:rerun-if-changed=build.rs");
}
