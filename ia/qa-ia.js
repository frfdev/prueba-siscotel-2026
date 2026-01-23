import "dotenv/config";
import { test } from "node:test";
import { Stagehand } from "@browserbasehq/stagehand";

test('Un usuario se crea una cuenta nueva', async() => {

    try {
        const stagehand = new Stagehand({
        env: "LOCAL",
        model: "deepseek/deepseek-r1",
        apiKey: process.env.DEEPSEEK_API_KEY
        });

        await stagehand.init();
        const page = stagehand.context.pages()[0];

        await page.goto(process.env.URL);

        await stagehand.act("Presion en el boton registrar");

        await stagehand.act("Rellena todos los campos del formulario y presiona crear");

        await stagehand.close();

        process.exit(1);

    } catch (error) {
        console.log('errror: ', error)
        process.exit(1);
    }
    
})