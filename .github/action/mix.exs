 name:GITHUB_WORKFLOW
 -env: APi_KEY:process.env()
 -For each:'$.respomd() '.
 }
defineComponent
({
  async run({ steps, $ }) {
    await $.respond({
      status: 200,
      headers: { "Authorization": "Bearer" },
      body: { message: "💦🔞🖕" }, // This can be any string, object, Buffer, or Readable stream
    });
  }
});
