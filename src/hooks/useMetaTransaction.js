import { useState } from "react";
import useBiconomyContext from "./useBiconomyContext";

const useMetaTransaction = ({ input, transactionParams }) => {
  const { contract } = useBiconomyContext();
  const [isMetatransactionProcessing, setIsMetatransactionProcessing] =
    useState(false);
  const [error, setError] = useState();
  console.log("#####: ", input );
  console.log("Tx Params: ", transactionParams)
  const onSubmitMetaTransaction = ({ onConfirmation, onError }) => {
    try {
      setIsMetatransactionProcessing(true);
      //let tx = contract.methods.setStorage(input).send(transactionParams);
      let tx = contract.methods.mint(input[0], input[1]).send(transactionParams);
      tx.on("transactionHash", function (hash) {
        console.log(`Transaction hash is ${hash}`);
      })
        .once("confirmation", function (transactionHash) {
          setIsMetatransactionProcessing(false);
          onConfirmation(transactionHash);
        })
        .on("error", function (e) {
          console.log("Error: ", e)
          setError(e);
          setIsMetatransactionProcessing(false);
          onError();
        });
    } catch (e) {
      setError(e);
      onError(e);
    }
  };

  return { error, isMetatransactionProcessing, onSubmitMetaTransaction };
};

export default useMetaTransaction;
