import { StrictMode } from "react";
import ReactDOM from "react-dom";
import App from "./App";
import { MoralisProvider } from "react-moralis";
import "./index.css";
import BiconomyContextProvider from "context/BiconomyProvider";

/** Get your free Moralis Account https://moralis.io/ */

const APP_ID = process.env.REACT_APP_MORALIS_APPLICATION_ID;
const SERVER_URL = process.env.REACT_APP_MORALIS_SERVER_URL;

console.log(APP_ID, SERVER_URL);

const Application = () => {
  return APP_ID && SERVER_URL ? (
    <MoralisProvider appId={APP_ID} serverUrl={SERVER_URL}>
      <BiconomyContextProvider>
        <App />
      </BiconomyContextProvider>
    </MoralisProvider>
  ) : (
    <div style={{ display: "flex", justifyContent: "center" }}>
      <App />
    </div>
  );
};

ReactDOM.render(
  <StrictMode>
    <Application />
  </StrictMode>,
  document.getElementById("root")
);
