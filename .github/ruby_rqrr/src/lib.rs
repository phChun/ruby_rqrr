use image;
use magnus::{
    exception, exception::ExceptionClass, function, prelude::*, value::Lazy, Error, RArray,
    RModule, Ruby,
};
use rqrr;
use std::path::Path;

static RUBY_RQRR: Lazy<RModule> = Lazy::new(|ruby| ruby.define_module("RubyRqrr").unwrap());

static ERROR: Lazy<ExceptionClass> = Lazy::new(|ruby| {
    ruby.get_inner(&RUBY_RQRR)
        .define_error("Error", ruby.exception_standard_error())
        .unwrap()
});

static QR_PARSE_ERROR: Lazy<ExceptionClass> = Lazy::new(|ruby| {
    ruby.get_inner(&RUBY_RQRR)
        .define_error("QrParseError", ruby.get_inner(&ERROR))
        .unwrap()
});

fn detect_qrs_in_image(ruby: &Ruby, file_path: String) -> Result<RArray, Error> {
    // Load the image
    let img_file = image::open(Path::new(&file_path))
        .map_err(|e| Error::new(exception::io_error(), e.to_string()))?
        .to_luma8();
    let mut img = rqrr::PreparedImage::prepare(img_file);
    let grids = img.detect_grids();
    let urls = RArray::new();

    for grid in grids {
        let (_, content) = grid
            .decode()
            .map_err(|e| Error::new(ruby.get_inner(&QR_PARSE_ERROR), e.to_string()))?;
        urls.push(content)?;
    }
    Ok(urls)
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    Lazy::force(&QR_PARSE_ERROR, ruby);
    ruby.get_inner(&RUBY_RQRR)
        .define_singleton_method("detect_qrs_in_image", function!(detect_qrs_in_image, 1))?;
    Ok(())
}
