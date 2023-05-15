import { test, expect } from "@playwright/test";

const syncLV = async (page) => await Promise.all([
    expect(page.locator(".phx-connected").first()).toBeVisible(),
    expect(page.locator(".phx-change-loading")).toHaveCount(0),
    expect(page.locator(".phx-click-loading")).toHaveCount(0),
    expect(page.locator(".phx-submit-loading")).toHaveCount(0),
]);

test("can submit a liveview form", async ({ page }) => {
    await page.goto("/");
    // wait for the liveview to be connected
    await syncLV(page);
    await page.getByLabel('Name').fill('Foo123123123');
    await page.getByLabel('E-Mail').fill('Bar');
    await syncLV(page);
    // check phx-ref to see if there are pending refs
    console.log(await page.locator("[data-phx-ref]").count());
    await page.getByRole('button', { name: 'Save' }).click();
    await expect(page.locator("span#save-indicator")).toContainText("Saved!");
});