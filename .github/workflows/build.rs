extern crate autocfg;

fn main() {
    let ac = autocfg::new();
    ac.emit_has_type("i128");

    // (optional) We don't need to rerun for anything external.
    autocfg::rerun_path("build.rs");
}
