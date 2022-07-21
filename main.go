package main

import (
    "fmt"
    "io/ioutil"
     "log"
     "os"
     "flag"
		 "strings"
		 "os/exec"

		 "github.com/manifoldco/promptui"
)

func MapToNames(in []os.FileInfo) []string {
	out := make([]string, len(in))
	for i, v := range in {
		out[i] = v.Name()
	}
	return out
}
func FilterForCubeExtension(in []string) []string {
	out := []string{}
	for _, v := range in {
		if(strings.HasSuffix(strings.ToLower(v), ".cube")){
			out = append(out, v)
		}
	}
	return out
}

func applyLut(lut string, inputFile string, outputName string) {
	fmt.Print("applying LUT \"" + lut + "\" to \""+ inputFile +"\" -> ")

	cmd := exec.Command("ffmpeg", "-vf", lut, "-c", "copy", "-i", inputFile, outputName)
	_, err := cmd.Output()

	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println("applied")
	}
}

func main() {
	lutDirPtr := flag.String("l", ".", "LUT Directory")
	filePtr := flag.String("f", "video.mp4", "Video Input File")
	allLutsPtr := flag.Bool("a", false, "Create Video with all LUTs")
	flag.Parse()


	fmt.Println(*lutDirPtr)
	files, err := ioutil.ReadDir(*lutDirPtr)
	if err != nil {
		log.Fatal(err)
	}

	options := FilterForCubeExtension(MapToNames(files))

	if(*allLutsPtr) {
		for _, file := range options {
			applyLut(*lutDirPtr + "/" + file, *filePtr, file + "_" + *filePtr)
		}
		return
	}

	prompt := promptui.Select{
		Label: "Select LUT",
		Items: options,
	}

	_, result, err := prompt.Run()

	applyLut(*lutDirPtr + "/" + result, *filePtr, result + "_" + *filePtr)
}
